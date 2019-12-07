rollout test_buttons "Testing Buttons"
(
  button theButton iconName:"" iconSize:[5,5]
  button theBorderlessButton "I am a button, too!" border:false
  on theButton pressed do
    messagebox "Remember: Never press unknown buttons!"
)
createDialog test_buttons 150 60