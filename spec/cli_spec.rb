require 'spec_helper'

require 'lol_dba'
require 'lol_dba/cli'

describe "Command line interface" do
  subject do
    LolDba::CLI.new('/tmp', options)
  end

  let(:options) { Hash.new }

  before(:each) do
    subject.stub(:load_application) { true }
  end

  it 'call simple migration if format is migration' do
    options[:format] = 'migration'
    subject.should_receive(:generate_migration)

    subject.start
  end

  it 'call sql generator if format is sql' do
    options[:format] = 'sql'
    subject.should_receive(:generate_sql)

    subject.start
  end

  it 'print error if format is invalid' do
    options[:format] = 'invalid'
    $stderr.should_receive(:puts).at_least(:once).with("Unknown format: invalid")
    $stderr.should_receive(:puts)

    subject.start
  end
end
