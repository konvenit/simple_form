module SimpleForm
  module Inputs
    class LocalizedInput < Base
      enable :placeholder, :maxlength, :pattern

      LANGUAGES = [:de, :en]

      def label
        result = if generate_label_for_attribute?
                   @builder.label(label_target, label_text, label_html_options)
                 else
                   template.label_tag(nil, label_text, label_html_options)
                 end

        switchers = LANGUAGES.map do |lang|
          classes = ["LanguageSelector-link is-#{lang}"]
          classes << 'is-selected' if lang == LANGUAGES.first

          @builder.content_tag(:a, nil, :class => classes.join(' '), :href => '#', :data => { :lang => lang })
        end

        [
            result,
            @builder.content_tag(:div, switchers.join.html_safe, :class => 'LanguageSwitchers')
        ].join.html_safe
      end

      def input
        input_html_options[:type] ||= 'text' unless string?
        add_size!

        orig_classes = [input_html_options[:class], 'js-localized'].flatten

        LANGUAGES.map do |lang|
          classes = orig_classes.dup
          classes << 'hidden' unless lang == LANGUAGES.first
          classes << "lang_#{lang}"

          generate_input lang, classes.join(' ')
        end.join.html_safe
      end

      private

      def string?
        input_type == :string
      end
    end
  end
end
