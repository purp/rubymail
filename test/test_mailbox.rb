#!/usr/bin/env ruby
#--
#   Copyright (c) 2002 Matt Armstrong.  All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. The name of the author may not be used to endorse or promote products
#    derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
# OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
# NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
# TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

require 'helper'
require 'rmail/mailbox'

class TestRMailMailbox < Test::Unit::TestCase
  include TestHelper
  
  def setup
    @mbox_data = open(fixture('mbox.simple')).readlines.join
    ### FIXME: calculate this from @mbox_data, or vice-versa
    @expected = ["From foo@bar  Wed Nov 27 12:27:32 2002\nmessage1\n",
      "From foo@bar  Wed Nov 27 12:27:36 2002\nmessage2\n",
      "From foo@bar  Wed Nov 27 12:27:40 2002\nmessage3\n"]
  end    
  
  def test_parse_mbox_simple
    assert_equal(@expected, RMail::Mailbox::parse_mbox(@mbox_data))
  end
  
  def test_parse_mbox_simple_with_block
    messages = []

    RMail::Mailbox::parse_mbox(@mbox_data) { |m|
      messages << m
    }
    assert_equal(@expected, messages)
  end
end
