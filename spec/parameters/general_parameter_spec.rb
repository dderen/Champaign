require 'rails_helper'
require 'spec_helper'

# Since the tests for our Parameter types are all identical (make sure
# that they correctly filter the right values and throw errors on the
# wrong ones), we define a hash of all the different Parameter types
# that we're going to test and then loop over each of them, plugging
# in the relevant values.

parameter_classes_to_test = {
    actionkit_page_type: {
        class_type: ActionkitPageTypeParameters,
        correct_params: { actionkit_page_type: 'test' }
    },
    actionkit_page: {
        class_type: ActionkitPageParameters,
        correct_params: {
            campaign_page_id: 1,
            actionkit_page_type_id: 'test'
        }
    },
    campaign_pages: {
        class_type: CampaignPageParameters,
        correct_params: {
            title: 'Awesome Campaign Page',
            slug: '/page/awesome-campaigns-page',
            active: true,
            featured: false
        }
    },
    campaign_pages_widget: {
        class_type: CampaignPagesWidgetParameters,
        correct_params: {
            content: 'This is some content',
            page_display_order: 1,
            widget_type_id: 1
        }
    },
    campaigns: {
        class_type: CampaignParameters,
        correct_params: {
            campaign_name: 'My campaigns!'
        }
    },
    language: {
        class_type: LanguageParameters,
        correct_params: {
            language_code: 'en',
            language_name: 'English'
        }
    },
    member: {
        class_type: MemberParameters,
        correct_params: {
            email_address: 'notarealemail@notarealdomain.notarealtld',
            actionkit_member_id: '1234564sga'
        }
    },
    widget_type: {
        class_type: WidgetTypeParameters,
        correct_params: {
            widget_name: 'Awesome Widget',
            specifications: 'Test',
            partial_path: '/partials/path',
            form_partial_path: '/partials/forms/path',
            active: false
        }
    }
}

# Here we do the actual looping with the repeated tests.

parameter_classes_to_test.each do |key, value|
  describe value[:class_type] do
    describe '.permit' do
      describe 'when permitted parameters' do
        it 'should permit actionkit_page_type' do
          page_params = value[:correct_params]
          params = ActionController::Parameters.new(key => page_params)
          permitted_params = value[:class_type].new(params).permit
          expect(permitted_params).to eq page_params.with_indifferent_access
        end
      end

      describe 'when unpermitted parameters' do
        it 'raises error' do
          page_params = {
              a_key_that_wil_seriously_never_get_used: 'a totally wrong value'
          }
          params = ActionController::Parameters.new(key => page_params)
          expect{ value[:class_type].new(params).permit }.
            to raise_error(ActionController::UnpermittedParameters)
        end
      end
    end
  end
end
