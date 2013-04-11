class Entry < ActiveRecord::Base

  attr_accessible :description, :end_time, :start_time

  belongs_to :invoice

  # Find pending or completed entries
  scope :pending,  where('end_time is null')
  scope :complete, where('end_time is not null')

  # Find entires that are part of the current invoice cycle
  scope :uninvoiced, where('invoice_id is null')

  # Order the entries by the most recent clocked-in times first
  scope :in_order, order('start_time DESC')

  # Check if this entry is currently pending completion
  def pending?
    end_time.nil?
  end

  def total_seconds
    (end_time or Time.now) - start_time
  end

  def hours
    total_seconds / 1.hour
  end

  def minutes
    (total_seconds % 1.hour) / 1.minute
  end

  def seconds
    ((total_seconds % 1.hour) / 1.minute) % 1.minute
  end

end
