require 'zip'
require 'nokogiri'
require 'tempfile'

Zip.on_exists_proc = true

module Mlatr
  class Document
    attr_reader :document, :word_zip, :styles
    attr_accessor :author, :instructor, :class_title, :date, :title, :body, :works_cited

    def initialize(path, &block)
      @word_zip = Zip::File.open path

      @document = Nokogiri::XML @word_zip.read 'word/document.xml'
      @styles = @word_zip.read 'word/styles.xml'

      parse

      if block_given?
        yield self
        @word_zip.close
      end

      self
    end

    # Returns an IO object for the thumbnail.
    def thumbnail
      img = Tempfile.new 'thumbnail.jpeg'
      @word_zip.extract 'docProps/thumbnail.jpeg', img
      img
    end

    def self.open(path, &block)
      self.new(path, &block)
    end


    private
    def parse
      paragraphs = @document.xpath('//w:document//w:body//w:p').map do |p|
        p.xpath('.//w:t').map { |t| t.text }.join ''
      end

      parse_author(paragraphs)
      parse_instructor(paragraphs)
      parse_class_title(paragraphs)
      parse_date(paragraphs)
      parse_title(paragraphs)
      parse_body(paragraphs)
      parse_works_cited(paragraphs)
    end

    def parse_author(paragraphs)
      @author = paragraphs[0].to_s
    end

    def parse_instructor(paragraphs)
      @instructor = paragraphs[1].to_s
    end

    def parse_class_title(paragraphs)
      @class_title = paragraphs[2].to_s
    end

    def parse_date(paragraphs)
      @date = paragraphs[3].to_s
    end

    def parse_title(paragraphs)
      @title = paragraphs[4].to_s
    end

    def parse_body(paragraphs)
      body = []

      paragraphs.drop(5).each do |p|
        if p === "Works Cited"
          break
        elsif p.empty?
          next
        else
          body << p
        end

      end

      @body = body.join "\n"
    end

    def parse_works_cited(paragraphs)
    end
  end
end