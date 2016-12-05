class StaticContentsController < ApplicationController
  ActiveContents = %w[home]

  ActiveContents.each do |content|
    class_eval <<-EOT
      def #{content}
      end
    EOT
  end
end
