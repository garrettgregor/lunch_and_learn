class ErrorSerializer
  def initialize(error)
    @error = error
  end

  def user_errors
    {
      errors: [
        {
          status: "404",
          title: @error
        }
      ]
    }
  end
end
