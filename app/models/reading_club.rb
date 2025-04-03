# frozen_string_literal: true

class ReadingClub < ApplicationRecord
  DEFAULT_TEMPLATE = <<~MARKDOWN
    ### これはテンプレート例です
      - 「作成」ボタンを押して、新しいノートを作成しましょう！
      - 作成したノートは共同編集ができます。輪読会で学んだことをみんなで記録しましょう😀

    ### 今日読んだ範囲
       - 「第〇章 p.xx」～「第〇章 p.yy」

    ### 学んだこと・分かったこと
      - Aさん
        - 〇〇というメソッドは、配列を△△したいときに利用する
      - Bさん
  MARKDOWN

  DEFAULT_READ_ME = <<~MARKDOWN
    # READ ME
    **輪読会のルールや読んで欲しいことを書きましょう！**

    ## 開催日時
    - 毎週月曜日 20:00~
    - 毎週水曜日 20:00~
    - 祝日はお休みです

    ## Discordリンク
    [リンク](https://example.com/)
  MARKDOWN

  attribute :template, default: DEFAULT_TEMPLATE
  attribute :read_me, default: DEFAULT_READ_ME

  validates :title, presence: true
  validates :finished, inclusion: { in: [true, false] }

  has_many :participants, dependent: :destroy
  has_many :users, through: :participants

  has_many :notes, dependent: :destroy

  scope :finished, -> { where(finished: true) }
  scope :open, -> { where(finished: false) }

  paginates_per 15

  class << self
    def ransackable_attributes(_auth_object = nil)
      %w[title finished]
    end

    def ransackable_associations(_auth_object = nil)
      %w[participants users]
    end
  end
end
