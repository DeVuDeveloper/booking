# frozen_string_literal: true

require 'pact'

def create_admin_user
  session_token = 'token-xxx123123'
  User.create id: -1, admin: true, hashed_session_token: User.pwd_hash(session_token)
end

Pact.provider_states_for 'Vespas UI' do
  provider_state 'a red bike model exists' do
    set_up do
      create_admin_user
      model1 = VespaModel.create text: 'Mountain'
      Bike.create id: 1, weight: 1.2, color: 'red', bike_model: model1, latitude: 48.210033, longitude: 16.363449,
                  average_rating: 1
    end
    tear_down do
      User.destroy_all
      Vespa.destroy_all
      VespaModel.destroy_all
    end
  end

  provider_state 'a vespa model exists' do
    set_up do
      create_admin_user
      VespaModel.create text: 'Mountain', id: 1
    end
    tear_down do
      User.destroy_all
      Vespa.destroy_all
      VespaModel.destroy_all
    end
  end

  provider_state 'a user exists' do
    set_up do
      create_admin_user
    end

    tear_down do
      User.destroy_all
    end
  end

  provider_state 'a user with reservation exists' do
    set_up do
      admin = create_admin_user
      model1 = VespaModel.create text: 'Mountain'
      vespa = Vespa.create weight: 1.2, color: Vespa::COLORS.first, vespa_model: model1, latitude: 48.210033,
                           longitude: 16.363449, average_rating: 1
      Reservation.create id: 1, user: admin, vespa: vespa
    end

    tear_down do
      Reservation.destroy_all
      Vespa.destroy_all
      VespaModel.destroy_all
      User.destroy_all
    end
  end

  provider_state 'a vespa exists' do
    set_up do
      create_admin_user
      model1 = VespaModel.create text: 'Mountain'
      Vespa.create id: 1, weight: 1.2, color: Vespa::COLORS.first, bike_model: model1, latitude: 48.210033,
                   longitude: 16.363449, average_rating: 1
    end

    tear_down do
      Vespa.destroy_all
      VespaModel.destroy_all
      User.destroy_all
    end
  end

  provider_state 'a Vespa with reservation exists' do
    set_up do
      create_admin_user
      model1 = VespaModel.create text: 'Mountain'
      vespa = Vespa.create weight: 1.2, color: Vespa::COLORS.first, vespa_model: model1, latitude: 48.210033,
                           longitude: 16.363449, average_rating: 1
      user = User.create email: 'boti@gmail.com'
      Reservation.create user: user, vespa: vespa
    end

    tear_down do
      Vespa.destroy_all
      VespaModel.destroy_all
      Reservation.destroy_all
      User.destroy_all
    end
  end

  provider_state 'a thing does not exist' do
    no_op # If there's nothing to do because the state name is more for documentation purposes,
    # you can use no_op to imply this.
  end
end
