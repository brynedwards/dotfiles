import           Data.List                        (isSuffixOf)
import           Data.Monoid                      (Endo)
import           GHC.IO.Handle.Types (Handle)
import           System.IO                        (hPutStrLn)
import           XMonad
import           XMonad.Actions.Commands
import           XMonad.Actions.PhysicalScreens
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.InsertPosition
import           XMonad.Hooks.ManageDocks
import           XMonad.Layout.IndependentScreens
import           XMonad.Layout.LayoutModifier     (ModifiedLayout)
import           XMonad.Prompt
import           XMonad.Prompt.Unicode
import qualified XMonad.StackSet                  as W
import           XMonad.Util.EZConfig
import           XMonad.Util.Run                  (spawnPipe)

type MyLayout = ModifiedLayout AvoidStruts (Choose Tall Full)

main :: IO ()
main = do
  xmobarMain    <- spawnPipe "xmobar"
  xmobarScreen2 <- spawnPipe "xmobar -x 1 ~/.config/xmobar/screen2.hs"
  xmonad $ ewmh $ docks
      def { terminal    = myTerm
          , modMask     = myModMask
          , borderWidth = 1
          , normalBorderColor = "#a0a0a0"
          , focusedBorderColor = "#eeeeee"
          , manageHook  = myManageHook
          , layoutHook  = myLayoutHook
          , workspaces  = withScreens 2 (map show ([1 .. 9] :: [Integer]))
          , logHook     = myLog 0 xmobarMain >> myLog 1 xmobarScreen2
          }
    `additionalKeys` myAdditionalKeys
 where
  myLog screen handle = dynamicLogWithPP . marshallPP screen . myPP $ handle

myModMask :: KeyMask
myModMask = mod4Mask

myBar :: String
myBar = "xmobar"

myTerm :: String
myTerm = "st"

myPP :: Handle -> PP
myPP h = xmobarPP { ppCurrent = xmobarColor "#44c7f1" ""
                  , ppSep     = " • "
                  , ppTitle   = xmobarColor "#ffaf64" "" . shorten 120
                  , ppOutput  = hPutStrLn h
                  }

myLayoutHook :: MyLayout a
myLayoutHook = avoidStruts $ Tall 1 (1 / 20) (1 / 2) ||| Full

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

myAdditionalKeys :: [((KeyMask, KeySym), X ())]
myAdditionalKeys =
  [ ((0, xK_Print)                   , spawn "scrot")
  , ((controlMask .|. mod1Mask, xK_j), spawn "pamixer -d 4")
  , ((controlMask .|. mod1Mask, xK_k), spawn "pamixer -i 4")
  , ((myModMask, xK_b)               , sendMessage ToggleStruts)
  , ((myModMask, xK_d)               , spawn "dictionary-lookup")
  , ((myModMask, xK_p)               , spawn "passdmenu -t")
  , ((myModMask, xK_r)               , spawn "dmenu_run_history")
  , ((myModMask, xK_u)               , unicodePrompt def)
  , ((myModMask, xK_w)               , onNextNeighbour W.view)
  , ((myModMask, xK_x)               , commands >>= runCommand)
  ]
   ++ [ ((m .|. myModMask, k), windows $ onCurrentScreen f i)
      | (i, k) <- zip myWorkspaces [xK_1 .. xK_9]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
      ]
  where myWorkspaces = map show ([1 .. 9] :: [Integer])

commands :: X [(String, X ())]
commands = defaultCommands
