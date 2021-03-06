class WidgetType < ActiveRecord::Base

  validates_presence_of :widget_name, :specifications, :partial_path, :form_partial_path
  # validating presence of a boolean field 'active'
  validates_inclusion_of :active, in: [true, false]
end
