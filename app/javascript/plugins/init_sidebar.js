
/* Set the width of the sidebar to 0 and the left margin of the page content to 0 */
const openNav = () => {
  document.getElementById("mySidebar").style.width = "250px";
  document.getElementById("main").style.marginLeft = "250px";
};

const closeNav = () => {
  document.getElementById("mySidebar").style.width = "0";
  document.getElementById("main").style.marginLeft = "0";
};

const hideButton = () => {
  document.getElementById("open-nav").style.display = 'none';
}

const showButton = () => {
  document.getElementById("open-nav").style.display = 'inline';
}

const initNav = () => {
  const openButton = document.getElementById("open-nav");
  openButton.addEventListener("click", (event) => {
    openNav();
    hideButton();
  })
  const closeButton = document.getElementById("close-nav");
  closeButton.addEventListener("click", (event) => {
    closeNav();
    showButton();
  })
}

export { initNav };


