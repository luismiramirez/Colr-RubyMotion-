class SearchController < UIViewController
  def viewDidLoad
    super
    self.title = "Search"
    self.view.backgroundColor = UIColor.whiteColor

    @text_field = UITextField.alloc.initWithFrame [[0,0], [160, 26]]
    @text_field.placeholder = "#abcabc"
    @text_field.textAlignment = UITextAlignmentCenter
    @text_field.autocapitalizationType = UITextAutocapitalizationTypeNone
    @text_field.borderStyle = UITextBorderStyleRoundedRect
    @text_field.center = [
        self.view.frame.size.width / 2,
        self.view.frame.size.height / 2 - 100]
    self.view.addSubview(@text_field)

    @search = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @search.setTitle("Search", forState: UIControlStateNormal)
    @search.setTitle("Loading", forState: UIControlStateDisabled)
    @search.sizeToFit
    @search.center = [
        self.view.frame.size.width / 2,
        @text_field.center.y + 40]
    self.view.addSubview(@search)

    @search.when(UIControlEventTouchUpInside) do
      @search.enabled = false
      @text_field.enabled = false
      @search.sizeToFit

      hex = @text_field.text
      hex = hex[1..-1] if hex[0] == "#"

      Color.find(hex) do |color|
        if color.nil?
          @search.setTitle("None :(", forState: UIControlStateNormal)
          @search.sizeToFit
        else
          @search.setTitle("Search", forState: UIControlStateNormal)
          self.open_color(color)
        end
        @search.enabled = true
        @text_field.enabled = true
      end
    end
  end

  def open_color(color)
    controller = ColorController.alloc.initWithColor(color)
    self.navigationController.pushViewController(controller, animated: true)
  end
end