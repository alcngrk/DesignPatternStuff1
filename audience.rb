class Audience
  def initialize(gladiator)
    gladiator.add_observer(self)
    if rand(2) == 0
      @rootsForGladiator = true
    else
      @rootsForGladiator = false
    end

    @responseType = ''
  end

  def update(offset, positiveResponse, negativeResponse, neutralResponse)
    if offset  > 0 && @rootsForGladiator == true
      @responseType = '+'
    elsif offset > 0 && @rootsForGladiator == false
      @responseType = '-'
    elsif offset < 0 && offset > -999999 && @rootsForGladiator == true
      @responseType = '-'
    elsif offset < 0 && offset > -999999 && @rootsForGladiator == false
      @responseType = '+'
    elsif offset == -999999
      @responseType = '0'
    end

    respond_accordingly(@responseType, positiveResponse, negativeResponse, neutralResponse)
  end

  def respond_accordingly(event, positiveResponse, negativeResponse, neutralResponse)
    if event == '+'
      positiveResponse.call()
    elsif event == '-'
      negativeResponse.call()
    elsif event == '0'
      neutralResponse.call()
    end
  end
end
