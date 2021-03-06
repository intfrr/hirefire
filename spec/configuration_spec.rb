# encoding: utf-8

require File.expand_path('../spec_helper', __FILE__)

describe HireFire::Configuration do

  it 'should have defaults' do
    configuration = HireFire.configuration

    configuration.environment.should      == nil
    configuration.max_workers.should      == 1
    configuration.job_worker_ratio.should == [
        { :jobs => 1,   :workers => 1 },
        { :jobs => 25,  :workers => 2 },
        { :jobs => 50,  :workers => 3 },
        { :jobs => 75,  :workers => 4 },
        { :jobs => 100, :workers => 5 }
      ]
  end

  it 'should be configurable' do
    HireFire.configure do |config|
      config.environment      = :noop
      config.max_workers      = 10
      config.job_worker_ratio = [
          { :jobs => 1,   :workers => 1 },
          { :jobs => 15,  :workers => 2 },
          { :jobs => 35,  :workers => 3 },
          { :jobs => 60,  :workers => 4 },
          { :jobs => 80,  :workers => 5 }
        ]
    end

    configuration = HireFire.configuration

    configuration.environment.should      == :noop
    configuration.max_workers.should      == 10
    configuration.job_worker_ratio.should == [
        { :jobs => 1,   :workers => 1 },
        { :jobs => 15,  :workers => 2 },
        { :jobs => 35,  :workers => 3 },
        { :jobs => 60,  :workers => 4 },
        { :jobs => 80,  :workers => 5 }
      ]
  end

end
