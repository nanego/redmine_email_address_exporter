Deface::Override.new :virtual_path  => 'projects/_list',
                     :original      => 'd3fb826a2bd63adc1df8f1fd9d6bd3706a548bab',
                     :name          => 'add-email-export-link-on-the-projects-page',
                     :insert_before => '#csv-export-options',
                     :partial       => 'projects/link_to_export'
