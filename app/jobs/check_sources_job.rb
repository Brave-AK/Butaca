class CheckSourcesJob < ActiveJob::Base
  queue_as :default

  before_perform do |job|
    @@before_size = MovieStream.all.size
  end

  after_perform do |job|
    count = @before_size - MovieStream.all.size
    Message.create(message: "#{count} streams added")
  end

  def perform(*args)
    client = Canistreamit::Client.new
    @count = 0
    Title.all.each do |t|
      t.check_sources(client)
      @count +=1
    end

  end

  def after(job)
    Message.create(message: "Movie streams for #{@count} titles updated")
  end


end
