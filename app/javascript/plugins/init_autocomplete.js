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
};

export { initAutocomplete };
