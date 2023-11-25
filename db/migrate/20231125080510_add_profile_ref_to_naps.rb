class AddProfileRefToNaps < ActiveRecord::Migration[7.0]
  def change
    # Add a new foreign key column without the NOT NULL constraint
    add_reference(:naps, :profile, foreign_key: true)

    # Iterate through existing naps and associate them with a profile
    Nap.all.each do |nap|
      profile = Profile.find_by(nap.profile_id)  
      nap.update(profile: profile) if profile
    end

    # Remove the old foreign key column
    remove_reference(:naps, :profile, foreign_key: true)

    # Add the foreign key column with the NOT NULL constraint
    add_reference(:naps, :profile, foreign_key: true, null: false)
  end
end
