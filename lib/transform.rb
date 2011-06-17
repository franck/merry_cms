class String
	# Converts a post title to its-title-using-dashes
  # All special chars are stripped in the process  
  def to_url
		return if self.nil?
    
    result = self.downcase

    # replace quotes by nothing
    result.gsub!(/['"]/, '')
    result.gsub!(/[’]/, '')

    # strip all non word chars
    result.gsub!(/\W/, ' ')

    # replace all white space sections with a dash
    result.gsub!(/\ +/, '-')

    # trim dashes
    result.gsub!(/(-)$/, '')
    result.gsub!(/^(-)/, '')
		
		result.gsub!(/[ÀÁÂÃâäàãá]/,'a')
		result.gsub!(/[ä]/,'ae')
		result.gsub!(/[ëêéè]/,'e')
		result.gsub!(/[ÌÍÎÏiìíîï]/,'i')
		result.gsub!(/[ÒÓÔÕÖòóôõö]/,'o')
		result.gsub!(/[ö]/,'oe')
		result.gsub!(/[ÙÚÛÜùúû]/,'u')
		result.gsub!(/[ü]/,'ue')
		result.gsub!(/[ýÿ]/,'y')
		result.gsub!(/[Ææ]/,'ae')
		result.gsub!(/[ñ]/,'n')
		result.gsub!(/[Çç]/,'c')
		result.gsub!(/[ß]/,'ss')
		
		result
  end
  
  def to_email
		return if self.nil?
    
    result = self.downcase

    # replace quotes by nothing
    result.gsub!(/['"]/, '')
    result.gsub!(/[’]/, '')

    # strip all non word chars
    result.gsub!(/\W/, ' ')

    # replace all white space sections with a dot
    result.gsub!(/\ +/, '.')

    # trim dashes
    result.gsub!(/(-)$/, '')
    result.gsub!(/^(-)/, '')
		
		result.gsub!(/[ÀÁÂÃâäàãá]/,'a')
		result.gsub!(/[ä]/,'ae')
		result.gsub!(/[ëêéè]/,'e')
		result.gsub!(/[ÌÍÎÏiìíîï]/,'i')
		result.gsub!(/[ÒÓÔÕÖòóôõö]/,'o')
		result.gsub!(/[ö]/,'oe')
		result.gsub!(/[ÙÚÛÜùúû]/,'u')
		result.gsub!(/[ü]/,'ue')
		result.gsub!(/[ýÿ]/,'y')
		result.gsub!(/[Ææ]/,'ae')
		result.gsub!(/[ñ]/,'n')
		result.gsub!(/[Çç]/,'c')
		result.gsub!(/[ß]/,'ss')
		
		result
  end
  
  
end