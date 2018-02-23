class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def verified_numbers
    [
      { number: '+46709529036', who: 'Stefan Wallin' },
      { number: '+46735284545', who: 'Pontus Ekholm' },
      { number: '+46703188620', who: 'Jenny Vesterlund' }
    ]
  end

  def tried_messages
    [
      { name: 'Hate 1', message: 'I hate your cunt ass, I hope you get raped by 20 villagers' },
      { name: 'Hate 2', message: 'You can sit on my big D you little whore' },
      { name: 'Neutral 1', message: 'Har inte sminkat mig sedan den tiden faktiskt. Använder kanske läppglans ibland men det är allt.' },
      { name: 'Neutral 2', message: 'Då hade jag nog svarat ”olivolja” eller något annat skit tror jag' }
    ]
  end

  def account_sid
    'ACbd7c80df8b420dfc748ab2ef378bef70'
  end

  def auth_token
    '960e58be377b2da52d981a06e2b2e1b5'
  end
end
