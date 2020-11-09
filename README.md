[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/joel/homebrew-encrypt)

![Ruby](https://github.com/joel/homebrew-encrypt/workflows/Ruby/badge.svg)

# Passy

A simple password encoder. The idea is too simple to encode in a human comprehensive level you password before writing them done in a physical notebook. This way you can safely keep your password in physical support without risked them to theft.

This can generate for you new password

    encrypt --generate

And recode it for writing purpose

    encrypt --password '<password generated>'

Note: For all actions, the result is stored into the current clipboard to make easy copy-pasting

if you want to pick up from the clipboard, you can pass the option

```
encrypt --clipboard => encoding
encrypt --clipboard --direction 'backward' => decoding
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'passy'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install passy

Install in the system

    ln -s <encrypt_pass> /usr/local/bin/

## Usage

```shell
bin/encrypt

Usage: Passy [options]

Specific options:
    -d, --direction ENCRYPTION_MODE  [OPTIONAL] Encryption (default) Or Decryption
    -p, --password PASSWORD          [REQUIRED] Password
        --[no-]verbose               Run verbosely
    -c, --[no-]clipboard             Get the content from the clipboard
    -v, --[no-]generate              Generate password

Common options:
    -h, --help                       Show this message
        --version                    Show version
-----------------------------------------------------------------------------------
bin/encrypt.rb --password '1%195bDf!g' --direction 'forward'
[OPTION] --direction:

    --direction 'forward'
    --direction 'backward'
-----------------------------------------------------------------------------------

Generate a password
encrypt --generate

/i?T1%sBUXQ6jkHP57h%pEHVF?!tmE+tQ4vwkaVd6uese
-----------------------------------------------------------------------------------

Get printable version
encrypt --clipboard

+i!T6?sbuxq7JKhp59H%pehvf%?tMe/tq4VWKAvD7UESE
-----------------------------------------------------------------------------------

Get back password
encrypt --clipboard --direction 'backward'

/i?T1%sBUXQ6jkHP57h%pEHVF?!tmE+tQ4vwkaVd6uese
-----------------------------------------------------------------------------------

Get back password
encrypt --password '+i!T6?sbuxq7JKhp59H%pehvf%?tMe/tq4VWKAvD7UESE' --direction 'backward'

/i?T1%sBUXQ6jkHP57h%pEHVF?!tmE+tQ4vwkaVd6uese
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/passy. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/passy/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Passy project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/passy/blob/master/CODE_OF_CONDUCT.md).
