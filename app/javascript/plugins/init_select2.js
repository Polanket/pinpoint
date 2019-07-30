import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  $(document).ready(function() {
    console.log($('.multiple-select'))

    $('.select2').select2({ width: '100%' }); // (~ document.querySelectorAll)
  });

};

export { initSelect2 };

