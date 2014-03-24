$(function() {
    $('#mailing_list_export_roles').select2();

    $('form#mailing-export-form').submit(function(e) {
        $('form#mailing-export-form').removeAttr("data-submitted");
    });
});
