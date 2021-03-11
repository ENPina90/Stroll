import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.getElementById('location_address');
  if (addressInput) {
    places({ container: addressInput });
  }
  const startingAddressInput = document.getElementById('starting_location_address');
  if (startingAddressInput) {
    places({ container: startingAddressInput });
  }
  const homeAddressInput = document.getElementById('home_location_address');
  if (homeAddressInput) {
    places({ container: homeAddressInput });
  }
  const workAddressInput = document.getElementById('work_location_address');
  if (workAddressInput) {
    places({ container: workAddressInput });
  }
};

export { initAutocomplete };
