FactoryGirl.define do
  factory :game do
    board_shape :rhombus
    board_size 2

    factory :game_with_player do
      after(:create) do |game|
        FactoryGirl.create(:player, game: game)
      end
    end
  end
end
