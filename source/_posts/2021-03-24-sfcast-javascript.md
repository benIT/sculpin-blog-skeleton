---
title: symfonycasts course notes - JavaScript for PHP Geeks

categories:
    - js
    - dev
tags:
---
# About 

This is raw notes from the great symfony cast course "JavaScript for PHP Geeks". 
Content have been fully copied/pasted from the official [public resource](https://symfonycasts.com/screencast/javascript).

# Notes 

## 1 - Lift Stuff! The js- Prefix
https://symfonycasts.com/screencast/javascript/js-class-prefix
Our goal is the second, and by prefixing the class with js-, it makes that crystal clear. This is a fairly popular standard: when you add a class for JavaScript, give it a js- prefix so that future you doesn't need to wonder which classes are for styling and which are for JavaScript. Future you will... thank you.


https://symfonycasts.com/screencast/javascript/js-class-prefix

    <a href="#" class="js-delete-rep-log">
        <span class="fa fa-trash"></span>
    </a>
    
        <script>
            $('.js-delete-rep-log').on('click', function() {
                console.log('todo delete!');
            });
        </script>


## 2 - (document).ready() & Ordering

https://symfonycasts.com/screencast/javascript/document-ready-ordering

put js at the bottom surrounded by  a `$(document).ready(function()`:

	
	    {{ parent() }}
	    <script>
		$(document).ready(function() {
		    $('.js-delete-rep-log').on('click', function () {
		        console.log('todo delete!');
		    });
		});
	    </script>
	


## 3 - All about Event Bubbling

https://symfonycasts.com/screencast/javascript/event-bubbling#play

So the $ in $table isn't doing anything special, but it is a fairly common convention to denote a variable that is a jQuery object.

    
        {{ parent() }}
        <script>
            $(document).ready(function() {
                var $table = $('.js-rep-log-table');
                $table.find('.js-delete-rep-log').on('click', function () {
                    console.log('todo delete!');
                });
                $table.find('tbody tr').on('click', function() {
                    console.log('row clicked!');
                });
            });
        </script>

## 4 - The Event Argument & stopPropagation

https://symfonycasts.com/screencast/javascript/event-propagation

It turns out that when you return false from a listener function, it is equivalent to calling e.preventDefault() and e.stopPropagation(). To prove it, remove the return false and refresh:

	
	    {{ parent() }}
	    <script>
		$(document).ready(function() {
		    var $table = $('.js-rep-log-table');
		    $table.find('.js-delete-rep-log').on('click', function (e) {
		        e.preventDefault();
		        console.log('todo delete!');
		    });
		    $table.find('tbody tr').on('click', function() {
		        console.log('row clicked!');
		    });
		});
	    </script>
	


e.preventDefault() versus e.stopPropagation()

The e.preventDefault() says: don't do the default, browser behavior for this event. Normally, when you "click" a "link", your browser navigates to its href... which is a #. So cool, e.preventDefault() stops that! But e.stopPropagation() tells your browser to not bubble this event any further up the DOM tree. And that's probably not what you want. Do you really want your event listener to be so bold that it decides to prevent all other listeners from firing? I've literally never had a use-case for this.


	
	    {{ parent() }}
	    <script>
		$(document).ready(function() {
		    var $table = $('.js-rep-log-table');
		    $table.find('.js-delete-rep-log').on('click', function (e) {
		        e.preventDefault();
		        console.log('todo delete!');
		    });
		    $table.find('tbody tr').on('click', function() {
		        console.log('row clicked!');
		    });
		});
	    </script>
	


## 5 - The DOM Element Object
https://symfonycasts.com/screencast/javascript/dom-element-object#play


Using e.target

Because there's another way to find out which element was clicked... a better way, and it involves our magical e event argument. Just say $(e.target). target is a property on the event object that points to the actual element that was clicked. Then, .addClass('text-danger'):


Actually, no... our browser is kinda lying to us: e.target is a DOM Element object. Google for that and find the W3Schools page all about it. You see, every element on the page is represented by a JavaScript object, a DOM Element object.



	$(e.target).addClass('text-danger');
<=>
	e.target.className = e.target.className+' text-danger';






## 6 - The Magical this Variable & currentTarget
https://symfonycasts.com/screencast/javascript/this-current-target#play


this is equivalent to e.currentTarget, the DOM Element that we originally attached our listener to.
Ultimately that means that we can say, $(this).addClass('text-danger'):
So, use the this variable, it's your friend. But realize what's going on: this is just a shortcut to e.currentTarget. That fact is going to become critically important in just a little while.


	
	    {{ parent() }}
	    <script>
		$(document).ready(function() {
		    var $table = $('.js-rep-log-table');
		    $table.find('.js-delete-rep-log').on('click', function (e) {
		        e.preventDefault();
		        $(this).addClass('text-danger');
		        $(this).find('.fa')
		            .removeClass('fa-trash')
		            .addClass('fa-spinner')
		            .addClass('fa-spin');
		    });
		    $table.find('tbody tr').on('click', function() {
		        console.log('row clicked!');
		    });
		});
	    </script>
	


## 7 - A Great Place to Hide Things! The data- Attributes

https://symfonycasts.com/screencast/javascript/data-attribute

Adding a data-url Attribute

This is a really common problem, and the solution is to somehow attach extra metadata to our DOM about the RepLog, so we can read it in JavaScript. And guess what! There's an official, standard, proper way to do this! It's via a data attribute. Yep, according to those silly "rules" of the web, you're not really supposed to invent new attributes for your elements. Well, unless the attribute starts with data-, followed by lowercase letters. That's totally allowed!


	
	    {{ parent() }}
	    <script>
		$(document).ready(function() {
		    var $table = $('.js-rep-log-table');
		    $table.find('.js-delete-rep-log').on('click', function (e) {
		        e.preventDefault();
		        $(this).addClass('text-danger');
		        $(this).find('.fa')
		            .removeClass('fa-trash')
		            .addClass('fa-spinner')
		            .addClass('fa-spin');
		        var deleteUrl = $(this).data('url');
		        var $row = $(this).closest('tr');
		        var $totalWeightContainer = $table.find('.js-total-weight');
		        var newWeight = $totalWeightContainer.html() - $row.data('weight');
		        $.ajax({
		            url: deleteUrl,
		            method: 'DELETE',
		            success: function() {
		                $row.fadeOut();
		                $totalWeightContainer.html(newWeight);
		            }
		        });
		    });
		    $table.find('tbody tr').on('click', function() {
		        console.log('row clicked!');
		    });
		});
	    </script>
	



## 8 - Organizing with Objects!
https://symfonycasts.com/screencast/javascript/javascript-objects

Don't Call your Handler Function: Pass It

There's one teenie detail I want you to notice: when we specify the event callback, this.handleRepLogDelete - we're not executing it:
I mean, there are no () on the end of it. Nope, we're simply passing the function as a reference to the on() function. If you forget and add (), things will get crazy.

	
	    {{ parent() }}
	    <script>
		var RepLogApp = {
		    initialize: function($wrapper) {
		        this.$wrapper = $wrapper;
		        this.$wrapper.find('.js-delete-rep-log').on(
		            'click',
		            this.handleRepLogDelete
		        );
		        this.$wrapper.find('tbody tr').on(
		            'click',
		            this.handleRowClick
		        );
		    },
		    handleRepLogDelete: function(e) {
		        e.preventDefault();
		        $(this).addClass('text-danger');
		        $(this).find('.fa')
		            .removeClass('fa-trash')
		            .addClass('fa-spinner')
		            .addClass('fa-spin');
		        var deleteUrl = $(this).data('url');
		        var $row = $(this).closest('tr');
		        var $totalWeightContainer = this.$wrapper.find('.js-total-weight');
		        var newWeight = $totalWeightContainer.html() - $row.data('weight');
		        $.ajax({
		            url: deleteUrl,
		            method: 'DELETE',
		            success: function() {
		                $row.fadeOut();
		                $totalWeightContainer.html(newWeight);
		            }
		        });
		    },
		    handleRowClick: function() {
		        console.log('row clicked!');
		    }
		};
		$(document).ready(function() {
		    var $table = $('.js-rep-log-table');
		    RepLogApp.initialize($table);
		});
	    </script>
	




## 9 - "Static" Objects & the this Variable


https://symfonycasts.com/screencast/javascript/static-objects-this#play

When this is not this

Here's the deal: whenever you are in a callback function, like the success callback of an AJAX call, the callback of an event listener, or even when passing a callback to the setTimeout() function, the this variable in your callback changes to be something else. And we already knew that! We know that this in our event handler is actually a reference to the DOM Element object that was clicked. So the this variable in handleRepLogDelete is not our RepLogApp object, even though we're inside of that object. Creepy!

We're going to talk a lot more about this situation... in a moment.
Referencing your Object "Statically"

Fortunately, for now, the fix is easy. If you think about it, the RepLogApp object is very similar to a class in PHP that has only static properties and methods. I mean, could we create multiple RepLogApp objects? Nope! There can only ever be one. And because of that, each property - like $wrapper - acts like a static property: you set and access it, but it's attached to our "static", single object: RepLogApp, not to an individual instance of RepLogApp.


	
	    {{ parent() }}
	    <script>
		var RepLogApp = {
		    initialize: function($wrapper) {
		        this.$wrapper = $wrapper;
		        this.$wrapper.find('.js-delete-rep-log').on(
		            'click',
		            this.handleRepLogDelete
		        );
		        this.$wrapper.find('tbody tr').on(
		            'click',
		            this.handleRowClick
		        );
		    },
		    updateTotalWeightLifted: function() {
		        var totalWeight = 0;
		        this.$wrapper.find('tbody tr').each(function() {
		            totalWeight += $(this).data('weight');
		        });
		        this.$wrapper.find('.js-total-weight').html(totalWeight);
		    },
		    handleRepLogDelete: function(e) {
		        e.preventDefault();
		        $(this).addClass('text-danger');
		        $(this).find('.fa')
		            .removeClass('fa-trash')
		            .addClass('fa-spinner')
		            .addClass('fa-spin');
		        var deleteUrl = $(this).data('url');
		        var $row = $(this).closest('tr');
		        $.ajax({
		            url: deleteUrl, 
		            method: 'DELETE',
		            success: function() {
		                $row.fadeOut('normal', function() {
		                    $row.remove();
		                    RepLogApp.updateTotalWeightLifted();
		                });
		            }
		        });
		    },
		    handleRowClick: function() {
		        console.log('row clicked!');
		    }
		};
		$(document).ready(function() {
		    var $table = $('.js-rep-log-table');
		    RepLogApp.initialize($table);
		});
	    </script>
	



## 10 - Getting to the bottom of the this Variable
https://symfonycasts.com/screencast/javascript/understanding-this-magic#play

How do I Know what this Is?

Here's the deal: when you call a function in JavaScript, you can choose to change what this is inside of that function when you call it. That means you could have one function and 10 different people could call your function and decide to set this to 10 different things.

Now, in reality, it's not that bad. But we do need to remember one rule of thumb: whenever you have a callback function - meaning someone else is calling a function after something happens - this will have changed. We've already seen this a lot: in the click functions, inside of .each(), inside of success and even inside of $row.fadeOut():

    
        {{ parent() }}
        <script>
            var RepLogApp = {
                initialize: function($wrapper) {
                    this.$wrapper = $wrapper;
                    this.$wrapper.find('.js-delete-rep-log').on(
                        'click',
                        this.handleRepLogDelete
                    );
                    this.$wrapper.find('tbody tr').on(
                        'click',
                        this.handleRowClick
                    );
                    var newThis = {cat: 'meow', dog: 'woof'};
                    this.whatIsThis.call(newThis, 'hello');
                },
                whatIsThis: function(greeting) {
                    console.log(this, greeting);
                },
                updateTotalWeightLifted: function() {
                    var totalWeight = 0;
                    this.$wrapper.find('tbody tr').each(function() {
                        totalWeight += $(this).data('weight');
                    });
                    this.$wrapper.find('.js-total-weight').html(totalWeight);
                },
                handleRepLogDelete: function(e) {
                    e.preventDefault();
                    $(this).addClass('text-danger');
                    $(this).find('.fa')
                        .removeClass('fa-trash')
                        .addClass('fa-spinner')
                        .addClass('fa-spin');
                    var deleteUrl = $(this).data('url');
                    var $row = $(this).closest('tr');
                    $.ajax({
                        url: deleteUrl,
                        method: 'DELETE',
                        success: function() {
                            $row.fadeOut('normal', function() {
                                $(this).remove();
                                RepLogApp.updateTotalWeightLifted();
                            });
                        }
                    });
                },
                handleRowClick: function() {
                    console.log('row clicked!');
                }
            };
            $(document).ready(function() {
                var $table = $('.js-rep-log-table');
                RepLogApp.initialize($table);
            });
        </script>
    


## 11 - Fixing "this" with bind()

https://symfonycasts.com/screencast/javascript/fixing-this-bind#play


But wow, that's a lot of work, and it'll be a bit ugly! Instead, there's a simpler way. First, realize that whenever you have an anonymous function, you could refactor it into an individual method on your object. If we did that, then I would recommend binding that function so that this is the RepLogApp object inside.

But if that feels like overkill and you want to keep using anonymous functions, then simply go above the callback and add var self = this

Use bind() to make sure that this is always this inside any methods in your object.
Make sure to reference your object with this, instead of your object's name. This isn't an absolute rule, but unless you know what you're doing, this will give you more flexibility in the long-run.


    
        {{ parent() }}
        <script>
            var RepLogApp = {
                initialize: function($wrapper) {
                    this.$wrapper = $wrapper;
                    this.$wrapper.find('.js-delete-rep-log').on(
                        'click',
                        this.handleRepLogDelete.bind(this)
                    );
                    this.$wrapper.find('tbody tr').on(
                        'click',
                        this.handleRowClick.bind(this)
                    );
                },
                updateTotalWeightLifted: function() {
                    var totalWeight = 0;
                    this.$wrapper.find('tbody tr').each(function() {
                        totalWeight += $(this).data('weight');
                    });
                    this.$wrapper.find('.js-total-weight').html(totalWeight);
                },
                handleRepLogDelete: function(e) {
                    e.preventDefault();
                    var $link = $(e.currentTarget);
                    $link.addClass('text-danger');
                    $link.find('.fa')
                        .removeClass('fa-trash')
                        .addClass('fa-spinner')
                        .addClass('fa-spin');
                    var deleteUrl = $link.data('url');
                    var $row = $link.closest('tr');
                    var self = this;
                    $.ajax({
                        url: deleteUrl,
                        method: 'DELETE',
                        success: function() {
                            $row.fadeOut('normal', function() {
                                $(this).remove();
                                self.updateTotalWeightLifted();
                            });
                        }
                    });
                },
                handleRowClick: function() {
                    console.log('row clicked!');
                }
            };
            $(document).ready(function() {
                var $table = $('.js-rep-log-table');
                RepLogApp.initialize($table);
            });
        </script>
    



## 12 - Immediately Invoked Function Expression!
https://symfonycasts.com/screencast/javascript/immediately-invoked-function-expression


There are two things to check out. First, all we're doing is creating a function: it starts on top, and ends at the bottom with the }. But by adding the (), we are immediately executing that function. We're creating a function and then calling it!

Why on earth would we do this? Because! Variable scope in JavaScript is function based. When you create a variable with var, it's only accessible from inside of the function where you created it. If you have functions inside of that function, they have access to it too, but ultimately, that function is its home.

Before, when we weren't inside of any function, our two variables effectively became global: we could access them from anywhere. But now that we're inside of a function, the RepLogApp and Helper variables are only accessible from inside of this self-executing function.

This means that when we refresh, we get Helper is not defined. We just made the Helper variable private!


## 13 - The window Object & Global Variables

 https://symfonycasts.com/screencast/javascript/window-global-vars#play

Inside of our self-executing function, we - of course - also have access to any global variables, like window or the $ jQuery variable. But, instead of relying on these global variables, you'll often see people pass those variables into the function. It's a little weird, so let's see it.


	(function(window, $) {
		//...
	})(window, jQuery);


Forget var? It goes Global!


To tell JavaScript to stop being such a pushover, at the top of the RepLogApp.js file, inside quotes, say 'use strict':

	'use strict';


## 15 - The Object prototype!

https://symfonycasts.com/screencast/javascript/object-prototype


Introducing the Prototype

To fix this, instead of adding the method via Helper.calculateTotalWeight, we need to say Helper.prototype.calculateTotalWeight:


	Helper.prototype.calculateTotalWeight = function() {
	...
	};



## 16 - prototype Versus __proto__
https://symfonycasts.com/screencast/javascript/prototype-proto

Here's the point of all of this: you do want to setup your objects so that they can be instantiated. And now we know how to do this. First, set your variable to a function: this
 will become the constructor:

	var Helper = function ($wrapper) {
	};

And second, add any methods or properties you need under the prototype key:


	Helper.prototype.calculateTotalWeight = function() {
		var totalWeight = 0;
		this.$wrapper.find('tbody tr').each(function () {
		    totalWeight += $(this).data('weight');
		});
		return totalWeight;
	    };


## 17 - Extending the Prototype

https://symfonycasts.com/screencast/javascript/extend-prototype#play



From now on, we'll pretty much be adding everything to the prototype key. But, it does get a little bit annoying to always need to say Helper.prototype.something = for every method.
No worries! We can shorten this with a shortcut that's similar to PHP's array_merge() function. Use $.extend() and pass it Helper.prototype and then a second object containing all of the properties you want to merge into that object. In other words, move our calculateTotalWeight() function into this and update it to be calculateTotalWeight: function:


	$.extend(window.RepLogApp.prototype, {
		updateTotalWeightLifted: function () {
		    this.$wrapper.find('.js-total-weight').html(
		        this.helper.calculateTotalWeight()
		    );
		},

	...
	}


## 18 - AJAXify the Form

In general, there are two ways to AJAXify this form submit. First, there's the simple, traditional, easy, and lazy way! That is, we submit the form via AJAX and the server returns HTML. For example, if we forget to select an item to lift, the AJAX would return the form HTML with the error in it so we can render it on the page. Or, if it's successful, it would probably return the new <tr> HTML so we can put it into the table. This is easier... because you don't need to do all that much in JavaScript. But, this approach is also a bit outdated.

The second approach, the more modern approach, is to actually treat your backend like an API. This means that we'll only send JSON back and forth. But this also means that we'll need to do more work in JavaScript! Like, we need to actually build the new <tr> HTML row by hand from the JSON data!




	 window.RepLogApp = function ($wrapper) {
		...        
		this.$wrapper.find('.js-new-rep-log-form').on(
		    'submit',
		    this.handleNewFormSubmit.bind(this)
		);
	}


	(function(window, $) {
	    $.extend(window.RepLogApp.prototype, {
		handleNewFormSubmit: function(e) {
		    e.preventDefault();
		    var $form = $(e.currentTarget);
		}
	    });
	})(window, jQuery);




## 19 - Old-School AJAX HTML
https://symfonycasts.com/screencast/javascript/old-school-ajax-html


            if ($request->isXmlHttpRequest()) {
                return $this->render('lift/_repRow.html.twig', [
                    'repLog' => $repLog
                ]);
            }

$.ajax({
                url: $form.attr('action'),
                method: 'POST',
                data: $form.serialize(),
                success: function(data) {
                    $tbody.append(data);
                    self.updateTotalWeightLifted();
                },
                error: function(jqXHR) {
                    $form.closest('.js-new-rep-log-form-wrapper')
                        .html(jqXHR.responseText);
                }
            });


## 20 - Delegate Selectors FTW! 

https://symfonycasts.com/screencast/javascript/old-school-ajax-html


Your New Best Friend: Delegate Selectors

But there's a much, much, much better way. AND, it comes with a fancy name: a delegate selector. Here's the idea, instead of attaching the listener to DOM elements that might be dynamically added to the page later, attach the listener to an element that will always be on the page. In our case, we know that this.$wrapper will always be on the page.

Here's how it looks: instead of saying this.$wrapper.find(), use this.$wrapper.on() to attach the listener to the wrapper:
        this.$wrapper.on(
            'click',
            this.handleRepLogDelete.bind(this)
        );

So always use delegate selectors: they just make your life easy



## 27 - All About Promises!

https://symfonycasts.com/screencast/javascript/all-about-promises

We all know that in JavaScript, a lot of things can happen asynchronously. For example, Ajax calls happen asynchronously and even fading out an element happens asynchronously: we call the fadeOut() function, but it doesn't finish until later. This is so common that JavaScript has created an interface to standardize how this is handled. If you understand how it works, you will have a huge advantage.


This article describes the two sides to a Promise. First, if you need to execute some asynchronous code and then notify someone later, then you will create a Promise object. That's basically what jQuery does internally when we tell it to execute an AJAX call. This isn't very common to do in our code, but we'll see an example later.

The second side is what we do all the time: this is when someone else is doing the asynchronous work for us, and we need to do something when it finishes. We're already doing stuff like this in at least 5 places in our code!

Whenever something asynchronous happen, there are two possible outcomes: either the asynchronous call finished successfully, or it failed. In Promise language, we say that the Promise was fulfilled or the Promise was rejected.


## 28 - Catching a Failed Promise

https://symfonycasts.com/screencast/javascript/promises-catch#play

The second way - and better way - to handle rejections, is to use the .catch() function. Both approaches are identical, but this is easier for me to understand. Instead of passing a second argument to .then(), close up that function and then call .catch()

## 29 - Promise catch: Catches Errors?

https://symfonycasts.com/screencast/javascript/promise-catch-error#play

Here's the deal: in reality, .catch() will be called if your Promise is rejected, or if a handler above it throws an error. Since our .then() calls _addRow() and that throws an exception, this ultimately triggers the .catch(). Again, this works a lot like the try-catch block in PHP!

## 30 - Making (and Keeping) a Promise
https://symfonycasts.com/screencast/javascript/create-your-own-promise#play

	_saveRepLog: function(data) {
	    return new Promise(function(resolve, reject) {
		$.ajax({
		    url: Routing.generate('rep_log_new'),
		    method: 'POST',
		    data: JSON.stringify(data)
		}).then(function(data, textStatus, jqXHR) {
		    $.ajax({
		        url: jqXHR.getResponseHeader('Location')
		    }).then(function(data) {
		        // we're finally done!
		        resolve(data);
		    });
		}).catch(function(jqXHR) {
		    reject(jqXHR);
		});
	    });
	},



## 31 - Promise Chaining
https://symfonycasts.com/screencast/javascript/promise-chaining#play

That's a long way of saying that other chained listeners, will wait until that internal Promise is resolved. In our example, it means that any .then() handlers attached to _saveRepLog() will wait until the inner AJAX call is finished. In fact, that's the whole point of Promises: to allow us to perform multiple asynchronous actions by chaining a few .then() calls, instead of doing the old, ugly, nested handler functions.


## 32 - SweetAlert: Killing it with Promises
https://symfonycasts.com/screencast/javascript/sweet-alert-more-promises

        handleRepLogDelete: function (e) {
            e.preventDefault();
            var $link = $(e.currentTarget);
            var self = this;
            swal({
                title: 'Delete this log?',
                text: 'What? Did you not actually lift this?',
                showCancelButton: true
            }).then(function () {
                self._deleteRepLog($link);
            }).catch(function(arg) {
                console.log('canceled', arg);
            });
        },


## 33 - Sweet Alert: Create a Promise!
https://symfonycasts.com/screencast/javascript/sweet-alert-create-promise#play