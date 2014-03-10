<script type='text/javascript' >
function startCalc(){
  interval = setInterval("calc()",1);
}
function calc(){
  one = document.autoSumForm.firstBox.value;
  two = document.autoSumForm.secondBox.value;
  document.autoSumForm.thirdBox.value = (one * 1) + (two * 1);
}
function stopCalc(){
  clearInterval(interval);
}
</script>
this is the html code

<form name="autoSumForm">
 
<input class="right" type=text name="firstBox" value="" onFocus="startCalc();" onBlur="stopCalc();"><br>
+ <input class="right" type=text name="secondBox" value="" onFocus="startCalc();" onBlur="stopCalc();"><br>
= <input class="right" type=text name="thirdBox">
</form>
