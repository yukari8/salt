class ShiftRequest < ActiveRecord::Base
  belongs_to :member
  validates :member_id, presence: true
  enum slot: %i(早番 遅番 泊り)

  def slot= value
    if value.kind_of?(String) and value.to_i.to_s == value
      super value.to_i
    else
      super value
    end
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << csv_column_names
      all.each do |shift_request|
        csv << shift_request.csv_column_values
      end
    end
  end

  def self.csv_column_names
    ['名前', '日付', 'シフト', 'コメント']
  end

  def csv_column_values
    [member.name, date, slot, comment]
  end
end
