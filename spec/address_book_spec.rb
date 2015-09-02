require_relative '../models/address_book.rb'

RSpec.describe AddressBook do

	let(:book) { AddressBook.new }

	def check_entry(entry, expected_name, expected_number, expected_email)
		expect(entry.name).to eql expected_name
		expect(entry.phone_number).to eql expected_number
		expect(entry.email).to eql expected_email
	end

	context "attributes" do
		it "should respond to entries" do
			expect(book).to respond_to(:entries)
		end

		it "should initialize entries as an array" do
			expect(book.entries).to be_a(Array)
		end

		it "should initialize entries as empty" do
			expect(book.entries.size).to eq 0
		end
	end

	context "#add_entry" do
		it "adds only one entry to the address book" do
			book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')

			expect(book.entries.size).to eq 1
		end

		it "adds the correct information to entries" do
			book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
			new_entry = book.entries[0]

			expect(new_entry.name).to eq 'Ada Lovelace'
			expect(new_entry.phone_number).to eq '010.012.1815'
			expect(new_entry.email).to eq 'augusta.king@lovelace.com'
		end
	end

	context "#remove_entry" do
		it "removes entry from the address book" do
			book = AddressBook.new
			book.add_entry('Homer Simpson', '010.032.2825', 'homer.simpson@simpson.com')

			name = "Ada Lovelace"
			phone_number = "010.012.1815"
			email_address = "augusta.king@lovelace.com"
			book.add_entry(name, phone_number, email_address)

			expect(book.entries.size).to eq 2
			book.remove_entry(name, phone_number, email_address)
			expect(book.entries.size).to eq 1
			expect(book.entries.first.name).to eq("Homer Simpson")
		end
	end

	context ".import_from_csv" do
		it "imports the correct number of entries" do
			book.import_from_csv("entries.csv")
			book_size = book.entries.size

			expect(book_size).to eql 5
		end

		it "imports the 1st entry" do
			book.import_from_csv("entries.csv")
			entry_one = book.entries[0]
			check_entry(entry_one, "Bill", "555-555-4854", "bill@blocmail.com")

		end

		it "imports the 2nd entry" do
			book.import_from_csv("entries.csv")

			entry_two = book.entries[1]
			check_entry(entry_two, "Bob", "555-555-5415", "bob@blocmail.com")
		end

		it "imports the 3rd entry" do
			book.import_from_csv("entries.csv")

			entry_three = book.entries[2]
			check_entry(entry_three, "Joe", "555-555-3660", "joe@blocmail.com")
		end

		it "imports the 4th entry" do
			book.import_from_csv("entries.csv")

			entry_four = book.entries[3]
			check_entry(entry_four, "Sally", "555-555-4646", "sally@blocmail.com")
		end

		it "imports the 5th entry" do
			book.import_from_csv("entries.csv")

			entry_five = book.entries[4]
			check_entry(entry_five, "Sussie", "555-555-2036", "sussie@blocmail.com")
		end

	end

	context ".import_from_csv" do
		it "imports another set of entries" do
			book.import_from_csv("entries_2.csv")
			book_size = book.entries.size

			expect(book_size).to eql 3
		end

		it "imports the first entry" do
			book.import_from_csv("entries_2.csv")
			entry_one = book.entries[0]
			check_entry(entry_one, "Ann", "222-111-2345", "ann@blocmail.com")

		end

		it "imports the second entry" do
			book.import_from_csv("entries_2.csv")
			entry_two = book.entries[1]
			check_entry(entry_two, "Joe", "333-222-1243", "joe@blocmail.com")
		end

		it "imports the third entry" do
			book.import_from_csv("entries_2.csv")
			entry_three = book.entries[2]
			check_entry(entry_three, "Tim", "111-222-1234", "tim@blocmail.com")
		end
	end
end