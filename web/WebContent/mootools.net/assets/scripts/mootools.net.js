var Site = {
	
	start: function(){
		
		if (Browser.Engine.trident) Site.fixExplorer();
		
		Site.Cookie = new Hash.Cookie('selections-005', {duration: 365});
		
		var download = ($('download'));
		if (download) Site.download();
	},
	
	download: function(){
		
		Site.trs = $$('tr.check, tr.radio');
		
		Site.trs.each(function(tr){
			tr.set('morph', {duration: 200});
			
			var input = tr.retrieve('own:input', tr.getElement('input').store('parent', tr));
			
			var td = tr.retrieve('own:td', tr.getElement('td.check'));
			
			td.getElement('input').setStyle('display', 'none');
			
			var div = tr.retrieve('own:div', new Element('div', {'class': 'input', 'morph': {duration: 140}}).inject(td));
			
			tr.addEvent('click', function(event){
				Site.toggle(this);
			});
			
		});
		
		Site.trs.each(function(tr){
			if (Site.Cookie.get(tr.retrieve('own:input').get('id'))){
				Site.check(tr);
			} else {
				Site.uncheck(tr, true);
			}
		});

		if (!document.getElement('input[type=radio]:checked')) Site.check($('download-options').getElement('tr.radio'));
	},
	
	toggle: function(tr){
		if (tr.retrieve('own:input').get('checked')){
			Site.uncheck(tr);
		} else {
			Site.check(tr);
		}
	},
	
	uncheckByName: function(tr, input){
		$$('input[name=' + input.get('name') + ']').each(function(other){
			if (other != input) Site.uncheck(other.retrieve('parent'), true);
		});
	},
	
	uncheck: function(tr, force){
		var input = tr.retrieve('own:input');
		if (!force && input.get('type') == 'radio'){
			if (input.get('checked')) return;
		}
		input.set('checked', false);
		
		var deps = input.get('deps');
		if (deps){
			Site.uncheckDepending(input.get('id'));
		}
		tr.retrieve('own:div').morph('.input');
		tr.morph('.blurred');
		
		Site.Cookie.set(input.get('id'), false);
	},
	
	check: function(tr){
		var input = tr.retrieve('own:input').set('checked', true);
		if (input.get('type') == 'radio'){
			Site.uncheckByName(tr, input);
		}
		var deps = input.get('deps');
		if (deps){
			Site.checkDependants(deps.split(','));
		}
		tr.retrieve('own:div').morph('.checked');
		tr.morph('.focused');
		
		Site.Cookie.set(input.get('id'), true);
	},
	
	checkDependants: function(deps){
		deps.each(function(input){
			input = $(input);
			if (input && !input.get('checked')) Site.check(input.retrieve('parent'));
		});
	},

	uncheckDepending: function(component){
		var depending = $$('input[deps]:checked').each(function(input){
			if (input.get('deps').split(',').contains(component)) Site.uncheck(input.retrieve('parent'));
		});
	},

	fixExplorer: function(){
		$$('table').set('cellspacing', 0);
	},

	selectAll: function(checked){
		$$('#download tr.check').each(Site.check);
	},

	selectNone: function(){
		$$('#download tr.check').each(Site.uncheck);
	}

};

window.addEvent('domready', function(){
	Site.start();
});
