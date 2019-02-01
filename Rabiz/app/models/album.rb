class Album < ApplicationRecord
    validates :band_id, :title, :version, presence: true 
    validates_inclusion_of :version, in: ['live', 'studio']

    belongs_to :band, 
    primary_key: :id,
    foreign_key: :band_id,
    class_name: :Band 

end
