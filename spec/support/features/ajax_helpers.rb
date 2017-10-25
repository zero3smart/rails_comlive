module Features
  module AjaxHelpers
    def wait_for_ajax
      Timeout.timeout(Capybara.default_max_wait_time) do
        loop until finished_all_ajax_requests?
      end
    end

    def wait_for_modal
      Timeout.timeout(Capybara.default_max_wait_time) do
        loop until login_modal_loaded?
      end
    end

    private

    def finished_all_ajax_requests?
      page.evaluate_script('$.active').zero?
    end

    def login_modal_loaded?
      page.evaluate_script("$('.auth0-lock-input-email').length").eql?(1)
    end
  end
end