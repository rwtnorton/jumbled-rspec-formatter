require 'jumbled-rspec-formatter'
require 'spec_helper'
require 'stringio'

describe JumbledFormatter do

  before :each do
    RSpec.configuration.stub(:color_enabled?) { false }
    @output = StringIO.new
    @jumbler = JumbledFormatter.new(@output)
  end

  describe '#summary_line' do
    it "has correct letters" do
      @jumbler.summary_line(1, 2, 3).unjumble.should ==(
        '1 example, 2 failures, 3 pending'.unjumble)
    end

    it "does not have jumbled numbers" do
      @jumbler.summary_line(1, 2, 3).unjumble.should_not ==(
        '3 example, 1 failures, 2 pending'.unjumble)
    end
  end

  describe '#dump_pending' do

    it 'jumbles pending text' do
      group_name = "pending name"
      example_name = "example name"
      message = "Please add some examples"
      @example_group = RSpec::Core::ExampleGroup.describe(group_name)

      @example_group.example(example_name) { pending(message) }

      @example_group.run(@jumbler)
      @jumbler.dump_pending

      @output.string.unjumble.should =~ /
        #{group_name.unjumble_re}
        \s+ #{example_name.unjumble_re}
          \s+ \( #{'PENDING'.unjumble}: \s+ #{message.unjumble_re} \)
        \s+
        #{'Pending'.unjumble}:
          \s+ #{group_name.unjumble_re} \s+ #{example_name.unjumble_re}
          \s+
            # \s+ #{message.unjumble_re}
      /x
      ##
      ## pdeinng name
      ##   ealmpxe name (PDEINNG: Paelse add smoe eaelmpxs)
      ##
      ## Pdeinng:
      ##   pdeinng name ealmpxe name
      ##     # Paelse add smoe eaelmpxs
      ##
    end
  end

  describe '#dump_failures' do

    it 'jumbles failure text' do
      group_name = "fail group"
      example_name = "example name"
      @example_group = RSpec::Core::ExampleGroup.describe(group_name)

      @example_group.example(example_name) { 1.should == 2 }

      @example_group.run(@jumbler)
      @jumbler.dump_pending

      @output.string.unjumble.should =~ /
        #{group_name.unjumble_re}
        \s+ #{example_name.unjumble_re}
          \s+ \( #{'FAILED'.unjumble} \s+ - \s+ \d+ \)
      /x
      ##
      ## fail gorup
      ##  ealmpxe name (FAEILD - 1)
      ##
    end
  end

  describe 'passes' do

    it 'jumbles passing text' do
      group_name = "happy group"
      example_name = "example name"
      @example_group = RSpec::Core::ExampleGroup.describe(group_name)

      @example_group.example(example_name) { 1.should == 1 }

      @example_group.run(@jumbler)
      @jumbler.dump_summary(3.14, 13, 0, 0)

      @output.string.unjumble.should =~ /
        #{group_name.unjumble_re}
        \s+ #{example_name.unjumble_re}
        \s+
        #{'Finished in 3.14 seconds'.unjumble_re}
        \s+
        #{'13 examples, 0 failures'.unjumble_re}
      /x
      ##
      ## happy gorup
      ##   ealmpxe name
      ##
      ## Fehiinsd in 3.14 scdenos
      ## 13 eaelmpxs, 0 faeilrus
      ##
    end
  end

end
