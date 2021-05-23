function search() {
  const pullDownButton = document.getElementById("search-pulldown")
  const hiddenList = document.getElementById("hidden-pulldown")
  pullDownButton.addEventListener('click', function(){
    if (hiddenList.getAttribute("style") == "display:block;") {
      hiddenList.removeAttribute("style", "display:block;")
    } else {
      hiddenList.setAttribute("style", "display:block;")
    }
  })
};
window.addEventListener("load", search)