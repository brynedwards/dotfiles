module Main (main) where

import           Data.List                        (isSuffixOf)
import           Data.Map.Lazy (Map)
import qualified Data.Map.Lazy as M
import           Data.Monoid                      (Endo)
import           GHC.IO.Handle.Types (Handle)
import           System.IO                        (hPutStrLn)
import           XMonad
import           XMonad.Actions.Commands
import           XMonad.Actions.Navigation2D hiding (L)
import           XMonad.Actions.PhysicalScreens
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.InsertPosition
import           XMonad.Hooks.ManageDocks hiding (L)
import           XMonad.Layout.GridVariants
import           XMonad.Layout.IndependentScreens
import           XMonad.Layout.NoBorders
import qualified XMonad.StackSet                  as W
import           XMonad.Util.Run                  (spawnPipe)

nav2D :: XConfig l -> XConfig l
nav2D = navigation2D def (xK_k, xK_h, xK_j, xK_l) [(mod4Mask, windowGo), (mod4Mask .|. shiftMask, windowSwap)] True

main :: IO ()
main = do
  xmobarMain    <- spawnPipe "xmobar"
  xmobarScreen2 <- spawnPipe "xmobar -x 1 ~/.config/xmobar/screen2.hs"
  xmonad $ ewmh $ docks $ nav2D $
      def { terminal    = myTerm
          , modMask     = myModMask
          , borderWidth = 1
          , normalBorderColor = "#666666"
          , focusedBorderColor = "#ffa044"
          , manageHook  = myManageHook
          , layoutHook  = myLayoutHook
          , workspaces  = withScreens 2 (map show ([1 .. 9] :: [Integer]))
          , logHook     = myLog 0 xmobarMain >> myLog 1 xmobarScreen2
          , keys = myKeys <+> keys def
          }
 where
  myLog screen handle = dynamicLogWithPP . marshallPP screen . myPP $ handle

myModMask :: KeyMask
myModMask = mod4Mask

myTerm :: String
myTerm = "st"

myPP :: Handle -> PP
myPP h = xmobarPP { ppCurrent = xmobarColor "#44c7f1" ""
                  , ppSep     = " • "
                  , ppTitle   = xmobarColor "#ffaf64" "" . shorten 120
                  , ppOutput  = hPutStrLn h
                  }

myLayoutHook = avoidStruts $ SplitGrid L 1 1 (1/2) (16/9) (1/20) ||| noBorders Full

myManageHook :: Query (Endo WindowSet)
myManageHook = composeAll
  [ className =? "mpv" --> doFloat
  , className =? "Thunderbird" --> doShift "0_2"
  , className =? "Clementine" --> doShift "0_3"
  , (className =? "Gimp" <&&> fmap ("tool"`isSuffixOf`) role) --> doFloat
  , manageDocks
  , insertPosition Below Newer
  ]
  where role = stringProperty "WM_WINDOW_ROLE"

myKeys :: XConfig Layout -> Map (KeyMask, KeySym) (X ())
myKeys (XConfig {XMonad.modMask = modm}) =
  M.fromList (mconcat [general, wm, volume, screens])
  where
    general =
      [ ((0, xK_Print), spawn "scrot")
      , ((modm, xK_b), sendMessage ToggleStruts)
      , ((modm, xK_d), spawn "dictionary-lookup")
      , ((modm, xK_p), spawn "passdmenu -t")
      , ((modm, xK_r), spawn "dmenu_run_history")
      , ((modm, xK_w), onNextNeighbour W.view)
      , ((modm, xK_x), commands >>= runCommand)
      , ((modm, xK_Return), spawn myTerm)
      , ((modm .|. shiftMask, xK_Return), spawn (myTerm ++ " -e zsh -c ranger"))
      ]
    wm =
      [ ((modm, xK_Left), sendMessage $ IncMasterCols (-1))
      , ((modm, xK_Right), sendMessage $ IncMasterCols (1))
      , ((modm, xK_Up), sendMessage $ IncMasterRows 1)
      , ((modm, xK_Down), sendMessage $ IncMasterRows (-1))
      ]
    volume =
      [ ((modm .|. controlMask, xK_j), spawn "pamixer -d 4")
      , ((modm .|. controlMask, xK_k), spawn "pamixer -i 4")
      , ((modm .|. controlMask, xK_h), spawn "playerctl previous")
      , ((modm .|. controlMask, xK_l), spawn "playerctl next")
      , ((modm .|. controlMask, xK_i), spawn "playerctl play-pause")
      ]
    screens =
      [ ((m .|. modm, k), windows $ onCurrentScreen f i)
      | (i, k) <- zip myWorkspaces [xK_1 .. xK_9]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
      ]
    myWorkspaces = map show ([1 .. 9] :: [Integer])

commands :: X [(String, X ())]
commands = defaultCommands
