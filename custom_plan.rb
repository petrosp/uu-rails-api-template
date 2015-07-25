require 'zeus/rails'


class CustomPlan < Zeus::Rails

  def default_bundle_with_test_env
    ::Rails.env = 'test'
    ENV['RAILS_ENV'] = 'test'
    default_bundle
  end

  # def default_bundle_with_development_env
  #   ::Rails.env = 'development'
  #   ENV['RAILS_ENV'] = 'development'
  #   default_bundle
  # end

  def test_console
    console
  end

  def dev_console
    ::Rails.env = 'development'
    ENV['RAILS_ENV'] = 'development'
    console
  end


  def rspec
    require 'factory_girl'
    FactoryGirl.reload
    super
  end

  # def my_custom_command
  #  # see https://github.com/burke/zeus/blob/master/docs/ruby/modifying.md
  # end

end

Zeus.plan = CustomPlan.new
