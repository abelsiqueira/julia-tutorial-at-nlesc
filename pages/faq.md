@def title = "Frequently Asked Questions"
@def showall = true

# {{fill title}}

\toc

#### Is the code portable?

In general, yes, but it depends on the packages you're using.
Some things are platform-dependant, like which library computes the time, and which application is used for downloads, but many things work seamlessly.

#### When should I use Julia instead of Python?

Disclaimer: This is highly biased by a Julia user.

The main advantages of Julia over Python are:
- Easy interoperability with lower-level languages.
- Speed is a bottleneck.
- Linear Algebra is first-class, i.e., matrices work directly.
- Vectorization of code is frequently not necessary.
- Amazing packages for Optimization and Differential Equations. Maybe more, my knowledge is limited.
- Multiple dispatch allows cool efficient compositions.
- Built-in package maintenance.

#### When should I use Python instead of Julia?

Disclaimer: This is highly biased by a Julia user.

The main advantages of Python over Julia are:
- Easier to find material.
- Has more _street cred_.
- Community is greater.
- Amazing packages for most needs.
- Quicker to load - no compilation overtime.

#### When/Where/In what are Julia and Python similar/equal?

Disclaimer: This is highly biased by a Julia user.

Python and Julia share many similarities:
- Easy to learn, read and write.
- Well funded.
- Stealing good things from other languages.

#### When/Where/In what are Julia and Python different but not clearly better?

Disclaimer: This is highly biased by a Julia user.

Main differences that are not already listed:
- Index start.
- Unicode in the code.
- Paradigm.