module Features
  module InputHelpers
    def select2(input_id,search_term,record_id,record_text)
      page.execute_script <<-JS
        $('##{input_id}').select2("open"); // open select2
        $('.select2-search__field').val("#{search_term}").trigger('keyup'); // emulate typing
      JS

      sleep(0.2) # wait for ajax to return

      # emulate selecting search result
      page.execute_script <<-JS
       $('##{input_id}').select2("trigger", "select", {
            data: { id: "#{record_id}", text: "#{record_text}" }
        });
      JS
    end

    def type_ahead(field, options = {})
      fill_in field, with: options[:with]

      page.execute_script %Q{ $('##{field}').trigger("focus") }
      page.execute_script %Q{ $('##{field}').trigger("keydown") }
    end

    def select_by_value(id, value)
      option_xpath = "//*[@id='#{id}']/option[@value='#{value}']"
      option = find(:xpath, option_xpath).text
      select(option, from: id)
    end

  end
end
