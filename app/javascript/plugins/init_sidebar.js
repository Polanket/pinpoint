
/* Set the width of the sidebar to 0 and the left margin of the page content to 0 */
const openNav = () => {
  document.getElementById("mySidebar").style.width = "250px";
  document.getElementById("main").style.marginLeft = "250px";
};

const closeNav = () => {
  document.getElementById("mySidebar").style.width = "0";
  document.getElementById("main").style.marginLeft = "0";
};

const initNav = () => {
  const openButton = document.getElementById("open-nav");
  openButton.addEventListener("click", (event) => {
    openNav();
  })
  const closeButton = document.getElementById("close-nav");
  closeButton.addEventListener("click", (event) => {
    closeNav();
  })
}

export { initNav };


