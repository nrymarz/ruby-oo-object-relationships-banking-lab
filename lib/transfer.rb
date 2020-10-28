class Transfer
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = 'pending'
    @amount = amount
  end
  attr_reader :amount, :sender, :receiver
  attr_accessor :status
  def valid?
    self.sender.valid? && self.receiver.valid?
  end
  def execute_transaction
    if self.status == 'pending' && self.sender.balance >= self.amount && self.valid?
      self.sender.balance -= self.amount
      self.receiver.balance += self.amount
      self.status = 'complete'
    elsif self.sender.balance < self.amount || !self.valid?
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end
  def reverse_transfer
    if self.status == 'complete'
      self.sender.balance += self.amount
      self.receiver.balance -= self.amount
      self.status = 'reversed'
    end
  end
end
