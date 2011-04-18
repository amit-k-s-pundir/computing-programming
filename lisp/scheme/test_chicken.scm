(require-extension ssax)
(require 'sxml)
;(sxml:document "http://modis.ispras.ru/Lizorkin/XML/poem.xml")
(ssax:xml->sxml "http://modis.ispras.ru/Lizorkin/XML/poem.xml")
