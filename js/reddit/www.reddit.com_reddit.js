
function
open_menu(menu){$(menu).siblings(".drop-choices").not(".inuse").css("top",menu.offsetHeight+'px').each(function(){$(this).css("left",$(menu).position().left+"px").css("top",($(menu).height()+
						$(menu).position().top)+"px");}).addClass("active
						inuse");};function
				close_menus(){$(".drop-choices.inuse").not(".active").removeClass("inuse");$(".drop-choices.active").removeClass("active");};function
				hover_open_menu(menu){};function update_user(form){try{var
						user=$(form).find("input[name=user]").val();form.action+="/"+user;}catch(e){}
					return true;} function post_user(form,where){var
						user=$(form).find("input[name=user]").val();if(user==null){return
							post_form(form,where);}else{return
								post_form(form,where+'/'+user);}}
						function
						post_form(form,where,statusfunc,nametransformfunc,block){try{if(statusfunc==null)
								statusfunc=function(x){return
									reddit.status_msg.submitting;};$(form).find(".error").not(".status").hide();$(form).find(".status").html(statusfunc(form)).show();return
								simple_post_form(form,where,{},block);}catch(e){return
									false;}};function
							get_form_fields(form,fields){fields=fields||{};$(form).find("select,
									input,
									textarea").not(".gray").each(function(){if(($(this).attr("type")!="radio"&&$(this).attr("type")!="checkbox")||$(this).attr("checked"))
											fields[$(this).attr("name")]=$(this).attr("value");});if(fields.id==null){fields.id=$(form).attr("id")?("#"+$(form).attr("id")):"";}
									return fields;};function
								simple_post_form(form,where,fields,block){$.request(where,get_form_fields(form,fields),null,block);return
									false;};function
								emptyInput(elem,msg){if(!$(elem).attr("value")||$(elem).attr("value")==msg)
									$(elem).addClass("gray").attr("value",msg).attr("rows",3);else
									$(elem).focus(function(){});};function
								showlang(){$(".lang-popup:first").show();return
									false;};function
								showcover(warning,reason){$.request("new_captcha");if(warning)
									$("#cover_disclaim,
										#cover_msg").show();else
									$("#cover_disclaim,
										#cover_msg").hide();$(".login-popup:first").show().find("form
											input[name=reason]").attr("value",(reason||""));return
										false;};function
									hidecover(where){$(where).parents(".cover-overlay").hide();return
										false;};function
									deleteRow(elem){$(elem).delete_table_row();};function
									change_state(elem,op,callback){var
										form=$(elem).parents("form");var
										id=form.find("input[name=id]");if(id.length)
										id=id.attr("value");else
										id=$(elem).thing_id();simple_post_form(form,op,{id:id});if(callback)callback(form,op);form.html(form.attr("executed").value);return
										false;};function
									save_thing(elem){$(elem).thing().addClass("saved");}
									function
									unsave_thing(elem){$(elem).thing().removeClass("saved");}
									function hide_thing(elem){var
										thing=$(elem).thing();thing.hide();if(thing.hasClass("hidden"))
										thing.removeClass("hidden");else
										thing.addClass("hidden");};function
									toggle(elem,callback,cancelback){var
										self=$(elem).parent().andSelf().filter(".option");var
										sibling=self.removeClass("active").siblings().addClass("active").get(0);if(cancelback&&!sibling.onclick){sibling.onclick=function(){return
												toggle(sibling,cancelback,callback);}}
										if(callback)callback(elem);return
										false;};function
									cancelToggleForm(elem,form_class,button_class,on_hide){if(button_class&&$(elem).filter("button").length){var
											sel=$(elem).thing().find(button_class).children(":visible").filter(":first");toggle(sel);}
										$(elem).thing().find(form_class).each(function(){if(on_hide)on_hide($(this));$(this).hide().remove();});return
										false;};function
									get_organic(elem,next){var
										listing=$(elem).parents(".organic-listing");var
										thing=listing.find(".thing:visible");if(listing.find(":animated").length)
										return false;var
										next_thing;if(next){next_thing=thing.nextAll(".thing:not(.stub)").filter(":first");if(next_thing.length==0)
											next_thing=thing.siblings(".thing:not(.stub)").filter(":first");}
										else{next_thing=thing.prevAll(".thing:not(.stub)").filter(":first");if(next_thing.length==0)
											next_thing=thing.siblings(".thing:not(.stub)").filter(":last");}
										thing.fadeOut('fast',function(){if(next_thing.length)
												next_thing.fadeIn('fast',function(){var
														n=5;var
														t=thing;var
														to_fetch=[];for(var
															i=0;i<2*n;i++){t=(next)?t.nextAll(".thing:first"):t.prevAll(".thing:first");if(t.length==0)
															t=t.end().parent().children((next)?".thing:first":".thing:last");if(t.filter(".stub").length)
															to_fetch.push(t.thing_id());if(i>=n&&to_fetch.length==0)
															break;}
														if(to_fetch.length){$.request("fetch_links",{links:to_fetch.join(','),listing:listing.attr("id")});}})});};function
									linkstatus(form){var
										title=$(form).find("#title").attr("value");if(title)
										return
										reddit.status_msg.submitting;return
										reddit.status_msg.fetching;};function
									subscribe(reddit_name){return
										function(){$.request("subscribe",{sr:reddit_name,action:"sub"});};};function
									unsubscribe(reddit_name){return
										function(){$.request("subscribe",{sr:reddit_name,action:"unsub"});};};function
									friend(user_name,container_name,type){return
										function(){$.request("friend",{name:user_name,container:container_name,type:type});}};function
									unfriend(user_name,container_name,type){return
										function(){$.request("unfriend",{name:user_name,container:container_name,type:type});}};function
									show_media(obj){obj=$.unsafe(obj);return
										function(elem){var
											where=$(elem).thing().find(".embededmedia");if(where.length)
											where.show().html(obj);else
											$(elem).new_thing_child('<div
												class="embededmedia">'+obj+'</div>');}};function
									cancelMedia(elem){return
										cancelToggleForm(elem,".embededmedia",".media-button");};function
									share(elem){$(elem).new_thing_child($(".sharelink:first").clone(true).attr("id","sharelink_"+$(elem).thing_id()),false);};function
									cancelShare(elem){return
										cancelToggleForm(elem,".sharelink",".share-button");};function
									helpon(elem){$(elem).parents("form:first").children(".markhelp:first").show();};function
									helpoff(elem){$(elem).parents("form:first").children(".markhelp:first").hide();};function
									chkcomment(form){var
										entry=$(form).find("textarea");if(entry.hasClass("gray")||!entry.attr("value")){return
											false;}else
										if(form.replace.value)
											return
										post_form(form,'editcomment',null,null,true);else
										return
										post_form(form,'comment',null,null,true);};function
									comment_edit(elem){return
										$(".commentreply:first").clone(true).find("button[name=cancel]").show().end().attr("id","commentreply_"+$(elem).thing_id());};function
									reply(elem){$(elem).new_thing_child(comment_edit(elem)).find('textarea:first').focus();};function
									editcomment(elem){var
										comment=$(elem).thing();var
										thing_name=comment.thing_id();var
										edit=comment_edit(elem);var
										content=comment.find(".edit-body:first").html();content=decodeURIComponent(content.replace(/\+/g,"
												"));edit.prependTo(comment).hide().find("button[name=comment]").hide().end().find("button[name=edit]").show().end().find("textarea").attr("value",content).removeClass("gray")
										edit.attr("parent").value=thing_name;edit.attr("replace").value=1;comment.children(".midcol,
											.entry").hide();edit.find("textarea:first").focus();edit.show();};function
									hidecomment(elem){$(elem).thing().hide().find(".noncollapsed:first,
											.midcol:first,
											.child:first").hide().end().show().find(".entry:first
												.collapsed").show();return
											false;};function
										showcomment(elem){var
											comment=$(elem).thing();comment.find(".entry:first
												.collapsed").hide().end().find(".noncollapsed:first,
													.midcol:first,
													.child:first").show().end().show();return
												false;};function
											cancelReply(elem){var
												on_hide=function(form){$.things($(form).attr("parent").value).children(".midcol,
														.entry").show();};return
												cancelToggleForm(elem,".commentreply",".reply-button",on_hide);};function
											morechildren(form,link_id,children,depth){$(form).html(reddit.status_msg.loading).css("color","red");var
												id=$(form).parents(".thing.morechildren:first").thing_id();$.request('morechildren',{link_id:link_id,children:children,depth:depth,id:id});return
												false;};function
											update_reddit_count(site){if(!site||!reddit.logged)return;var
												decay_factor=.9;var
												decay_period=86400;var
												num_recent=10;var
												num_count=100;var
												date_key='_date';var
												cur_date=new
												Date();var
												count_cookie='reddit_counts';var
												recent_cookie='recent_reddits';var
												reddit_counts=$.cookie_read(count_cookie).data;if(!$.defined(reddit_counts)){reddit_counts={};reddit_counts[date_key]=cur_date.toString();}
												var
												last_reset=new
												Date(reddit_counts[date_key]);var
												decay=cur_date-last_reset>decay_period*1000;reddit_counts[site]=$.with_default(reddit_counts[site],0)+1;var
												names=[];$.each(reddit_counts,function(sr_name,value){if(sr_name!=date_key){if(decay&&sr_name!=site){var
																val=Math.floor(decay_factor*reddit_counts[sr_name]);if(val>0)
																reddit_counts[sr_name]=val;else
																delete
																reddit_counts[sr_name];}
															if(reddit_counts[sr_name])
																names.push(sr_name);}});names.sort(function(n1,n2){return
																		reddit_counts[n2]-reddit_counts[n1];});if(decay)reddit_counts[date_key]=cur_date.toString();var
															recent_reddits="";for(var
																i=0;i<names.length;i++){var
																sr_name=names[i];if(i<num_recent){recent_reddits+=names[i]+',';}else
																if(i>=num_count&&sr_name!=site){delete
																	reddit_counts[sr_name];}}
															$.cookie_write({name:count_cookie,data:reddit_counts});if(recent_reddits)
															$.cookie_write({name:recent_cookie,data:recent_reddits});};function
														add_thing_to_cookie(thing,cookie_name){var
															id=$(thing).thing_id();var
															cookie=$.cookie_read(cookie_name);cookie.data+=":"+id;while(cookie.data.length>1000){var
																i=cookie.data.indexOf(":");if(i<0){cookie.data="";break;}
																cookie.data=cookie.data.slice(i+1);}
															$.cookie_write(cookie);};function
														updateEventHandlers(thing){thing=$(thing);var
															listing=thing.parent();$(thing).filter(".promotedlink").bind("onshow",function(){var
																	id=$(this).thing_id();if($.inArray(id,reddit.tofetch)!=-1){$.request("onload",{ids:reddit.tofetch.join(",")});reddit.tofetch=[];}
																	var
																	tracker=reddit.trackers[id];if($.defined(tracker)){$(this).find("a.title").attr("href",tracker.click).end().find("img.promote-pixel").attr("src",tracker.show);delete
																		reddit.trackers[id];}}).filter(":visible").trigger("onshow");$(thing).find("a.title").mousedown(function(){var
																				sr=reddit.sr[$(this).thing_id()]||reddit.cur_site;update_reddit_count(sr);$(this).addClass("click");add_thing_to_cookie(this,"click");var
																				wasorganic=$(this).parents('.organic-listing').length>0;last_click(thing,wasorganic);});if(listing.filter(".organic-listing").length){thing.find(".hide-button
																						a,
																						.del-button
																						a.yes,
																						.report-button
																						a.yes").each(function(){$(this).get(0).onclick=null});thing.find(".hide-button
																							a").click(function(){var
																									a=$(this).get(0);change_state(a,'hide',function(){get_organic(a,1);});});thing.find(".del-button
																									a.yes").click(function(){var
																											a=$(this).get(0);change_state(a,'del',function(){get_organic(a,1);});});thing.find(".report-button
																											a.yes").click(function(){var
																													a=$(this).get(0);change_state(a,'report',function(){get_organic(a,1);});});}};function
																									last_click(thing,organic){var
																										cookie="last_thing";if(thing){var
																											data={href:window.location.href,what:$(thing).thing_id(),organic:organic};$.cookie_write({name:cookie,data:data});}else{var
																												current=$.cookie_read(cookie).data;if(current&&current.href==window.location.href){var
																													olisting=$('.organic-listing');if(current.organic&&olisting.length==1){if(olisting.find('.thing:visible').thing_id()==current.what){}else{var
																															thing=olisting.things(current.what);if(thing.length>0&&!thing.hasClass('stub')){olisting.find('.thing:visible').hide();thing.show();}else{var
																																thingelsewhere=$.things(current.what).filter(':not(.stub):first');if(thingelsewhere.length>0){thing.remove();var
																																	othercopy=thingelsewhere.clone();olisting.find('.thing:visible').before(othercopy).hide();othercopy.show();}else{thing.remove();olisting.find('.thing:visible').before('<div
																																			class="thing
																																			id-'+current.what+'
																																			stub"
																																			style="display:
																																			none"></div');$.request('fetch_links',{links:[current.what],show:current.what,listing:olisting.attr('id')});}}}}
																														$.things(current.what).addClass("last-clicked");$.cookie_write({name:cookie,data:""});}}};function
																											login(elem){if(cnameframe)
																												return
																												true;return
																												post_user(this,"login");};function
																											register(elem){if(cnameframe)
																												return
																												true;return
																												post_user(this,"register");};$(function(){$("body").set_thing_init(updateEventHandlers);$("textarea.gray,
																															input.gray").focus(function(){$(this).attr("rows",7).filter(".gray").removeClass("gray").attr("value","")});if(reddit.logged)
																														$.cookie_name_prefix(reddit.logged);$.default_cookie_domain(reddit.cur_domain.split(':')[0]);if(reddit.cur_site)
																														update_reddit_count(reddit.cur_site);last_click();});
