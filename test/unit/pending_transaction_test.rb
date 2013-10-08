# == Schema Information
#
# Table name: pending_transactions
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  amount        :decimal(, )
#  desecription  :text
#  custom_credit :string(255)
#  custom_debit  :string(255)
#  shortcode     :string(255)
#  credited_id   :integer
#  debited_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class PendingTransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
