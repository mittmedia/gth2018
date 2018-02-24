class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def verified_numbers
    [
      { number: '+46709529036', who: 'Sten' },
      { number: '+46735284545', who: 'Fredrik' },
      { number: '+46703188620', who: 'Anna' }
    ]
  end

  def tried_messages
    [
      { name: 'Hat 1', message: 'Du ska dö en snar död din jävel' },
      { name: 'Hat 2', message: 'Fittjävel, måtte du våldta av skäggebarn' },
      { name: 'Neutral 1', message: 'Har inte sminkat mig sedan den tiden faktiskt. Använder kanske läppglans ibland men det är allt.' },
      { name: 'Neutral 2', message: 'Det var länge sen jag fick ett bra ligg!' }
    ]
  end

  def account_sid
    'ACbd7c80df8b420dfc748ab2ef378bef70'
  end

  def auth_token
    '960e58be377b2da52d981a06e2b2e1b5'
  end
end
