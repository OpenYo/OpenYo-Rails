module YosHelper
  def make_history(yos)
    yos.map do |yo|
      user = User.find(yo["from_id"])
      {
        user: user.name,
        yoed_at: yo["created_at"]
      }
    end
  end
end
