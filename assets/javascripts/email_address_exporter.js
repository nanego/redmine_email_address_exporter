$(function() {
    if ((typeof $().select2) === 'function') {
        $('#mailing_list_export_roles').select2();
        $('#mailing_list_export_functions').select2();
    }

    $('form#mailing-export-form').submit(function(e) {
        $('form#mailing-export-form').removeAttr("data-submitted");
    });
});
