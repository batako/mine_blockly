--[[
Copyright (c) 2014, Robert 'Bobby' Zenz
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--]]


--- Various functions related to nodeboxes.
nodeboxutil = {
	X_AXIS_INDEXES = { 1, 4 },
	Y_AXIS_INDEXES = { 2, 5 },
	Z_AXIS_INDEXES = { 3, 6 }
}


--- Sets the height of the nodebox to the new value.
--
-- @param nodebox The nodebox.
-- @param new_height The new height.
-- @return The new nodebox with the new height.
function nodeboxutil.set_height(nodebox, new_height)
	local new_nodebox = tableutil.clone(nodebox)
	local fixed = new_nodebox
	if fixed.fixed ~= nil then
		fixed = fixed.fixed
	end
	
	for index, block in ipairs(fixed) do
		for axis_index_index, axis_index in ipairs(nodeboxutil.Y_AXIS_INDEXES) do
			block[axis_index] = ((block[axis_index] + 0.5) * new_height) - 0.5
		end
	end
	
	return new_nodebox
end

