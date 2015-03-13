Spree::Image.class_eval do

    has_attached_file   :attachment,
                        :storage => :aliyun,
                        styles: { mini: '48x48>', small: '100x100>', product: '240x240>', large: '600x600>' },
                        default_style: :product,
                        url: '/spree/products/:id/:style/:basename.:extension',
                        path: ':rails_root/public/spree/products/:id/:style/:basename.:extension',
                        convert_options: { all: '-strip -auto-orient -colorspace sRGB' }

    before_create :randomize_file_name

    private

    def randomize_file_name
        extension = File.extname(attachment_file_name).downcase
        self.attachment.instance_write(:file_name, "#{SecureRandom.hex(16)}#{extension}")
    end
end