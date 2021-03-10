 const start = () => {
  const home = document.getElementById("home-address");
  const inputField = document.getElementById("starting_location_address");
  if (home) {
    home.addEventListener('click', (event) => {
      inputField.value = event.target.innerText;
    });
  }

  const work = document.getElementById("work-address");
  if (work) {
    work.addEventListener('click', (event) => {
      inputField.value = event.target.innerText;
    });
  }
}

export {start}
