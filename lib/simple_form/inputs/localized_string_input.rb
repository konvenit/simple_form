module SimpleForm
  module Inputs
    class LocalizedStringInput < LocalizedInput
      private

      def generate_input(lang, classes)
        @builder.text_field("#{attribute_name}_#{lang}", input_html_options.merge(:class => classes))
      end
    end
  end
end
