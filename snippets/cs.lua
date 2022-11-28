local snippet_utils = require("user.utils.snippets")
local cs_snippet_utils = require("user.utils.snippets.cs")

local ls_ok, ls = pcall(require, "luasnip")

if not ls_ok then
	return
end

local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local ri = snippet_utils.ri

local nmsp = s(
	"nmsp",
	fmt(
		[[
      namespace {1};
      public {2} {3}
      {{
          {}
      }}
      ]],
		{
			f(function()
				local buf_name = vim.api.nvim_buf_get_name(0)

				return cs_snippet_utils.compose_namespace(buf_name)
			end),
			f(function()
				local filename = snippet_utils.get_current_buffer_filename()
				local first_letter = filename:sub(0, 1)
				local second_letter = filename:sub(1, 2)

				if first_letter == "I" and string.upper(second_letter) == second_letter then
					return "interface"
				else
					return "class"
				end
			end),
			f(snippet_utils.get_current_buffer_filename),
			i(0),
		}
	)
)

local prop = s("prop", fmt("public {1} {} {{ get; set; }}", { i(1, "string"), i(0, "Prop") }))

local ctor = s(
	"ctor",
	fmt(
		[[
        public {1}()
        {{
            {}
        }}
    ]],
		{
			f(function()
				return snippet_utils.get_node_identifier(cs_snippet_utils.get_cs_constructable_node())
			end),
			i(0),
		}
	)
)

local mediatr = s(
	"mediatr",
	fmt(
		[[
			using MediatR;
			using Willpe.Domain.Errors;
			using Willpe.Domain.Utils;
			using Willpe.Infra;

			public record {1}() : IRequest<EitherContainer<Response, Error>>;
			
			public class {2} : IRequestHandler<{3}, EitherContainer<Response, Error>>
			{{
				private readonly DatabaseContext _databaseContext;

				public {4}(DatabaseContext databaseContext)
				{{
					_databaseContext = databaseContext;
				}}

				public async Task<EitherContainer<Response, Error>> Handle({5} request, CancellationToken cancellationToken)
				{{
					{}
				}}
			}}
		]],
		{
			f(function()
				return snippet_utils.get_current_buffer_filename()
			end),
			f(function()
				return snippet_utils.get_current_buffer_filename() .. "Handler"
			end),
			f(function()
				return snippet_utils.get_current_buffer_filename()
			end),
			f(function()
				return snippet_utils.get_current_buffer_filename() .. "Handler"
			end),
			f(function()
				return snippet_utils.get_current_buffer_filename()
			end),
			i(0),
		}
	)
)

local test = s(
	"test",
	fmt(
		[[
	[Fact]
	public async Task {1}()
	{{
		// Arrange
		{}

		// Act

		// Assert
	}}
]],
		{
			i(1),
			i(0),
		}
	)
)

return {
	nmsp,
	prop,
	ctor,
	mediatr,
	test,
}
