# == Schema Information
#
# Table name: transactions
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  amount        :decimal(8, 2)
#  description   :text
#  credited_id   :integer
#  debited_id    :integer
#  custom_credit :string(255)
#  custom_debit  :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
