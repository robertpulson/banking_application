# Definition of Overdrafts module
# this module will be responsible for all overdraft functionality
# displaying overdrafts and switching them on/off
module Overdrafts
  # method to display the status of an overdraft
  def show_overdraft(id)
    # takes an arg of account id
    OverdraftStatusMessage.new(find id)
    # find the accont and passes it as an arg to the message initialize method
    # returns this message
  rescue ItemExist, OverdraftDenied => message
    # catches exceptions, saves them to a message and executes the code inside the rescue block
    message
    # returns message
  end

  # method to activate an overdraft
  def activate_overdraft(id, amount)
    # takes an account id and an overdraft amount as args
    account = find id
    # find account and assigns to local variable
    account.activate_overdraft amount
    # converts the amount to an integer and set the accounts overdraft to it
    OverdraftStatusMessage.new(account)
    # creates a success message and passes the account as an arg
  rescue ItemExist, OverdraftDenied, GreaterThanZero => message
  # catches exceptions, saves them to a message and executes the code inside the rescue block
    account.switch_off_overdraft
    message
    # returns message
  end

  # method to deactivate an overdraft
  def deactivate_overdraft(id)
    # takes account id as an arg
    account = find id
    # finds account with the id and assigns to local variable
    account.switch_off_overdraft
    # swiches overdraft off
    OverdraftStatusMessage.new(account)
    # creates success message and passes account as an arg
  rescue ItemExist, OverdraftDenied => message
    # catches exceptions, saves them to a message and executes the code inside the rescue block
    message
    # returns messsage
  end
end
